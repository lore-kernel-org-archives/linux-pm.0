From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.26-rc4-git] PM: boot time suspend selftest
Date: Thu, 29 May 2008 21:34:19 -0700
Message-ID: <200805292134.19388.david-b__48917.8882599392$1212122412$gmane$org@pacbell.net>
References: <200805291333.42057.david-b@pacbell.net>
	<200805292329.48896.rjw@sisk.pl>
	<20080529160632.816e1720.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080529160632.816e1720.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

On Thursday 29 May 2008, Andrew Morton wrote:
> =

> > Could you check, please? =A0The previous version didn't.
> > =

> =

> There's just one trivial reject against the PCI tree's
> pm-introduce-new-top-level-suspend-and-hibernation-callbacks:

Thanks Andrew ... in that case I'm not going to worry
about any "-next" issues for now.

- Dave


> ***************
> *** 293,299 ****
> =A0 =A0=A0=A0=A0=A0=A0if (suspend_ops->finish)
> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0suspend_ops->finish();
> =A0 =A0Resume_devices:
> =A0 =A0=A0=A0=A0=A0=A0device_resume();
> =A0 =A0Resume_console:
> =A0 =A0=A0=A0=A0=A0=A0resume_console();
> =A0 =A0Close:
> --- 342,350 ----
> =A0 =A0=A0=A0=A0=A0=A0if (suspend_ops->finish)
> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0suspend_ops->finish();
> =A0 =A0Resume_devices:
> + =A0=A0=A0=A0=A0=A0suspend_test_start();
> =A0 =A0=A0=A0=A0=A0=A0device_resume();
> + =A0=A0=A0=A0=A0=A0suspend_test_finish("resume devices");
> =A0 =A0Resume_console:
> =A0 =A0=A0=A0=A0=A0=A0resume_console();
> =A0 =A0Close:
