From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 24 Jun 2006 16:41:23 +1000
Message-ID: <1151131283.10141.79.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Also note that it might be useful to implement something I've been
carrying around as a patch for debugging suspend on the mac, is what I
call "fake suspend". I did it as a kernel argument that turns the real
suspend into a fake suspend, but we should be smarter.

The idea is, as I may have described already, to do the whole driver
suspend/resume without actually putting the system to sleep in between
(whatver you do to ACPI to go to S3, whatever I do to the PMU to finish
the suspend process on macs). In addition, you can have the video device
"mark" (with flags maybe) the device chain all the way up from the video
device so that it's skipped by the suspend and resume calls. (that is
the console is not actually suspended).

That allows you to exercise pretty much 99% of the driver suspend and
resume code. It's not perfect as the chips will usually never do the D3
-> D3cold transition, and thus will not be in the same state on resume
than with a real suspend, but it's already a lot.

Then, you can do a script running fake suspend cycles over and over
again, while doing things like playing MP3s out of a USB disk while
copying files to an NFS server etc etc etc... and wait for it to
crash :)

Ben.
 =
