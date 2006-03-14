From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 23:07:21 +0100
Message-ID: <200603142307.22355.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0603141636060.1003-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0603141636060.1003-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Victor Porton,
	, , " <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 14 March 2006 22:42, Alan Stern wrote:
> On Tue, 14 Mar 2006, Pavel Machek wrote:
> 
> > > > Even if you make sure *kernel* is consistent with changed filesystem,
> > > > userland is going to be badly confused. Imagine what will happen with
> > > > memory mapped files, for example. 
> > > 
> > > Something like what happens when you suspend with a mounted CD
> > > and mmapped files from there, then you replace the CD while suspended
> > > and resume.  Not a wise thing to do, but I think people will do such things
> > > from time to time and we'd better be prepared to handle them nicely.
> > 
> > But... we can't prevent userspace from segfaulting in such case... can
> > we?
> > 
> > > > I'm not sure how it could work...
> > > 
> > > IMO memory mapped files are the most difficult problem here,
> > > but the rest seems to be doable in general.
> > 
> > It seems to be the same problem with removable media... You could
> > replace mounted CDrom while running. (Not all CDroms support door
> > lock.)
> 
> In theory, any SCSI device is supposed to realize when the medium has been 
> changed and notify the host by responding to the next command with a Unit 
> Attention sense key.  That's how medium changes while the system _isn't_ 
> suspended get detected.
> 
> The situation becomes much more problematic when the SCSI device itself is
> powered off.  In that case (which includes the "hardware doesn't support
> USB power during suspend" problem discussed at great length earlier), the
> kernel has only two choices.  Either assume that the medium _has_ been
> changed -- or more generally, that a new device is present -- or else try
> to verify somehow that the current medium is the same as the old medium.
> 
> This verification can't be certain, so there would always be a chance for 
> error.  Besides, right now the kernel contains no code for making such 
> verifications.

The question here, as far as I understand it, is whether we can write such a
code and, if so, whether it's worth doing.  I'm not sure of any of these now,
but the problem is interesting. :-)

Greetings,
Rafael
