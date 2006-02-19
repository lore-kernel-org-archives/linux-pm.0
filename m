From: Andrew Morton <akpm@osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 19 Feb 2006 12:02:21 -0800
Message-ID: <20060219120221.1d11cee0.akpm@osdl.org>
References: <43F89F55.5070808@cfl.rr.com>
	<Pine.LNX.4.44L0.0602191142290.9165-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============56991862515060543=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0602191142290.9165-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: alon.barlev@gmail.com, torvalds@osdl.org, linux-pm@lists.osdl.org, psusi@cfl.rr.com, linux-kernel@vger.kernel.org, mrmacman_g4@mac.com
List-Id: linux-pm@vger.kernel.org

--===============56991862515060543==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sun, 19 Feb 2006, Phillip Susi wrote:
> 
> > Andrew Morton wrote:
> > >>
> > >>  Hrm... interesting but sounds like that could be sticky.  For instance, 
> > >>  what if the user script that does the verifying happens to be ON the 
> > >>  volume to be verified?
> > > 
> > > Well that would be a bug.  Solutions would be a) don't put the scripts on a
> > > removable/power-downable device or b) use tmpfs.
> > > 
> > 
> > I don't see how it could be a bug, just think of the root on usb case. 
> > Keeping the program locked in ram would sidestep that issue, but tmpfs 
> > is pagable right?  Swap on usb?
> > 
> > Also, this user space program isn't going to be able to keep fully up to 
> > date on what the disk looks like.  Imagine a filesystem that keeps a 
> > generation counter in the super block and increments it every time it 
> > writes to the disk.  The user space daemon might read that, then the fs 
> > changes it, you suspend, and when you wake up, the daemon thinks the 
> > media changed because it wasn't fully up to date.
> 
> There are other, harder problems associated with doing this is userspace.
> 
> Really, the device needs to be considered separately at each level of
> driver processing.  At the USB level it may still appear to be the same,
> but at the SCSI level it may appear different.  Or at the SCSI level it
> may be the same, but at the gendisk level it may be different (different
> media, partition table changed).  Or at the gendisk level it may be the
> same, but at the filesystem level one or more of the partitions may be
> different (superblock changed).
> 
> Each level would need its own way of checking for changes and recreating 
> the appropriate data structures.  And while making the determinations, we 
> would need to temporarily set the device to read-only.  Yes, userspace 
> could do _some_ of the work, but it would need a lot of help from the 
> kernel.
> 

There are two things here: a) identifying the device and b) putting it into
the correct place in the various data structures.  I suspect these can (and
should) be separated out.

For a), the current kernel behaviour is what we want - make the thing
appear at a new place in the namespace and in the hierarchy.  Then
userspace can do whatever needs to be done to identify the device, and
apply some sort of policy decision to the result.

It's what comes next that we're missing: the ability for userspace to tell
the krnrel what the decice's naming and positioning _should_ be.  The
kernel will then atomically tear down what it currently has and will then
set everything up as desired.


--===============56991862515060543==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============56991862515060543==--
