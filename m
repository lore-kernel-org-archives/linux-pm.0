From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: swsusp limits
Date: Tue, 9 Aug 2005 00:47:47 +0200
Message-ID: <20050808224747.GB2012@elf.ucw.cz>
References: <Pine.LNX.4.50.0508081248540.1704-100000@shark.he.net>
	<20050808220746.GA1821@elf.ucw.cz>
	<1123540613.7296.2.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============061049506513913387=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1123540613.7296.2.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============061049506513913387==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Is there an option or possibility of using a dedicated swap
> > > partition for suspend to disk?
> > > Or maybe there is no reason to think that this might help?
> > 
> > I don't see how it could help.
> 
> If it was turned on at the right time, it might not be used by other
> things that could get swapped out by high memory usage and/or the memory
> eating process.

Yes, but if it is used all the time, it will work okay, too.

> > > If my application(s) causes lots of memory & swap space
> > > to be used (over half of the total system RAM), is it correct
> > > that it is likely to be useless to try to suspend to disk
> > > while that app is running?
> > 
> > No, it should work okay, as long as you do not mlock() it. Just prepare
> > big enough swap partition.
> 
> Will he even need to worry about the size of his swap partition? I
> though swsusp discarded everything it could anyway. (Perhaps you could
> add this question to the FAQ too).

If he has *lot* of data, he needs big swap partition. Of course,
everything I _can_ discard will be discarded.

This is what I ended up:
							Pavel

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -334,3 +334,18 @@ some kind of "really read-only!" option.
 image (and blocksize), with resume parameter pointing directly to
 suspend header.
 
+Q: Is there a maximum system RAM size that is supported by swsusp?
+
+A: It should work okay with highmem.
+
+Q: Does swsusp (to disk) use only one swap partition or can it use
+multiple swap partitions (aggregate them into one logical space)?
+
+A: Only one swap partition, sorry.
+
+Q: If my application(s) causes lots of memory & swap space to be used
+(over half of the total system RAM), is it correct that it is likely
+to be useless to try to suspend to disk while that app is running?
+
+No, it should work okay, as long as your app does not mlock() it. Just
+prepare big enough swap partition.


-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============061049506513913387==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============061049506513913387==--
