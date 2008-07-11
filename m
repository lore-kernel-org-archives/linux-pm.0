From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ioctl conversion
Date: Fri, 11 Jul 2008 10:08:20 +0200
Message-ID: <200807111008.21497.arnd__40248.18176772$1215787148$gmane$org@arndb.de>
References: <6d291e080807101728j62be7c93qba11aa214a8dfe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6d291e080807101728j62be7c93qba11aa214a8dfe1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stoyan Gaydarov <stoyboyker@gmail.com>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 11 July 2008, Stoyan Gaydarov wrote:
> - =A0 =A0 =A0 if (_IOC_TYPE(cmd) !=3D SNAPSHOT_IOC_MAGIC)
> + =A0 =A0 =A0 lock_kernel();
> +
> + =A0 =A0 =A0 if (_IOC_TYPE(cmd) !=3D SNAPSHOT_IOC_MAGIC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unlock_kernel();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOTTY;
> - =A0 =A0 =A0 if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR)
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unlock_kernel();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOTTY;
> - =A0 =A0 =A0 if (!capable(CAP_SYS_ADMIN))
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!capable(CAP_SYS_ADMIN)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unlock_kernel();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> + =A0 =A0 =A0 }
> =

> =A0 =A0 =A0 =A0 data =3D filp->private_data;

The more common way to express this is to end the function with

out:
	unlock_kernel();
	return ret;
}

and then jump to that label in the error case. This makes it
much easier to verify that you haven't missed a cased.

	Arnd <><
