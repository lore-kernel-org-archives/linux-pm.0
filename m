From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 17 Aug 2006 12:18:57 +0300
Message-ID: <1155806337.30834.17.camel@localhost>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060815190439.GI7612@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Dave Jones <davej@redhat.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-08-15 at 15:04 -0400, ext Dave Jones wrote:
> =

>  > d. In the end, all this is leading to an interface for a user-space
>  > policy manager that will control _system_ power state based on
>  > constraints imposed by HW peripherals or on policies implemented by
>  > device manufacturer/distro maintainer.
> =

> How does that interface look from a userspace point of view ?
> Hopefully not anything like the tuple described above.
> Why would userspace ever care about "interconnect freq" ?
> =

> Userspace cares about "save power" or "go fast".
> Historically, I wish we had never exposed frequencies, but instead
> a performance percentage, so that the various userspace tools
> didn't have to care about things like 'what frequencies are
> available'.
> Adding the same mistake for voltages doesn't strike me as a fantastic
> idea. =


The userspace interface in Eungeny's patches is for other userspace
programs (policy managers) to activate/deactivate valid operating points
in the system dynamically and if necessary, introduce new ones into the
system. It will also allow the operating points to be referenced by name
instead of the tuple.

Then, we will be able to use names like 'video', 'mp3', 'fast',
'powersave', 'usb' to switch to the relevant operating point based on
configuration of the policy manager.

Regards,
Amit

-- =

Amit Kucheria <amit.kucheria@nokia.com>
Nokia
