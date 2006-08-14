From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: BUG while suspending to swap on LVM
Date: Tue, 15 Aug 2006 00:35:15 +0200
Message-ID: <200608150035.15471.rjw@sisk.pl>
References: <44E0A995.50806@free.fr> <200608142337.56843.rjw@sisk.pl>
	<44E0F930.4090702@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44E0F930.4090702@free.fr>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 15 August 2006 00:29, Laurent Riffard wrote:
> Le 14.08.2006 23:37, Rafael J. Wysocki a =E9crit :
> > On Monday 14 August 2006 23:25, Laurent Riffard wrote:
> >> Le 14.08.2006 22:50, Rafael J. Wysocki a =E9crit :
> >>> On Monday 14 August 2006 22:03, Laurent Riffard wrote:
> >>>> Le 14.08.2006 21:16, Rafael J. Wysocki a =E9crit :
> >>>>> On Monday 14 August 2006 19:48, Laurent Riffard wrote:
> >>>>>> Le 14.08.2006 19:30, Rafael J. Wysocki a =E9crit :
> > ]--snip--[
> >>>> Does it mean it was mistaken on swap device ?
> >>> Yes.  If your resume device is not the first swap, it won't work with=
out
> >>> the patch.
> >> Ok, that's why I had that strange behaviour:
> >> - 2 swap devices online, suspend to second one: suspend works.
> >> - on resume, it can't find suspend signature on the 2nd swap device, so
> >>   it continue with normal boot, fsck all FS and say something like "sw=
apon: =

> >>   1st swap device busy". I had to mkswap it.
> >>
> >> I was thinking that my initrd script was broken or I was mistyping the=
 resume =

> >> device name in GRUB. Was funny...
> > =

> > Sorry for that.
> > =

> > This is not related to the BUG you've reported, but could you please tr=
y to
> > suspend using the second swap as your resume partition with a patched k=
ernel,
> > just to make sure the patch works?  I have no boxes with two swaps to v=
erify
> > this ...
> =

> It seems to always suspend to the first swap device, despite your patch.

Strange.

Well, thanks for testing!

Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
