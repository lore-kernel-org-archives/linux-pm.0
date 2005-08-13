From: Dave Jones <davej@redhat.com>
Subject: Software suspend support in Fedora.
Date: Sat, 13 Aug 2005 01:16:42 -0400
Message-ID: <20050813051642.GB11456@redhat.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
	<20050731222751.GA28907@redhat.com>
	<20050803092301.GA1352@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31603962820833242=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050803092301.GA1352@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============31603962820833242==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 03, 2005 at 11:23:01AM +0200, Pavel Machek wrote:

 > > The outcome: I'm no more enthusiastic about enabling this in Red Hat
 > > kernels than I ever was before.  It seems to have real issues with LVM
 > > setups (which is default on Red Hat/Fedora installs these days).
 > > After convincing it where to suspend/resume from by feeding it
 > > the major/minor of my swap partition, it did actually seem
 > > to suspend. And resume (though it did spew lots of 'sleeping whilst
 > > atomic warnings, but thats trivial compared to whats coming up
 > > next).
 > 
 > I do not know much about LVM. How exactly did you resume= command line
 > look like? You were not resuming from initrd, right?

Indeed, this was very likely the problem. Doing a resume if I had
any partition mounted was *bad* news.  We implemented the necessary
bits in our initrd today to detect resume partitions, and erm.. resume them.
So far so good, no repeats of the corruption I saw.

As of tomorrow rawhide kernels (for the unenlightened: these will
eventually be FC5) will have software suspend support.

Our initial experiments with it have been fairly positive, though as
expected there are a number of drivers that don't survive the resume
correctly. http://www.livejournal.com/users/kernelslacker/22975.html
has more info on this.  As we start getting users jumping on this, I
imagine more of these bugs will appear. But without testing, these are
never going to get fixed eh ? :)

 > Could you try to suspend on plain old swap-partition, first, to verify
 > that your drivers cooperate?
 
So, we've tested in on a /dev/hdaX, /dev/sdaX, and /dev/mapper/VolGroup00-LogVol01
so far, and its done the right thing every time.

It's looking pretty good, and unless something catastrophic happens,
we'll be supporting this feature from now on.
Whilst it's likely still got some niggles that need working out, 
It's come a long way since I last spent time looking into this, and
I'm sure it'll get there.  Kudos to all involved.

		Dave


--===============31603962820833242==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31603962820833242==--
