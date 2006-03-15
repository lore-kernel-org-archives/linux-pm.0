From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: standby to disk transition
Date: Wed, 15 Mar 2006 10:14:56 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0603151004180.5380-100000@iolanthe.rowland.org>
References: <200603142307.22355.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21454375792857094=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603142307.22355.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Victor Porton,
	, , " <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

--===============21454375792857094==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 14 Mar 2006, Rafael J. Wysocki wrote:

> > The situation becomes much more problematic when the SCSI device itself is
> > powered off.  In that case (which includes the "hardware doesn't support
> > USB power during suspend" problem discussed at great length earlier), the
> > kernel has only two choices.  Either assume that the medium _has_ been
> > changed -- or more generally, that a new device is present -- or else try
> > to verify somehow that the current medium is the same as the old medium.
> > 
> > This verification can't be certain, so there would always be a chance for 
> > error.  Besides, right now the kernel contains no code for making such 
> > verifications.
> 
> The question here, as far as I understand it, is whether we can write such a
> code and, if so, whether it's worth doing.  I'm not sure of any of these now,
> but the problem is interesting. :-)

I'm pretty sure that we _can_, but it would be a fair amount of work.  
(I'm not at all sure whether it's worth doing.)

Such a verification would have to take place at several different levels.  
For instance, with a USB device:

	The USB stack would have to verify that the transport was still 
	the same (same USB descriptors);

	The SCSI stack would have to verify that the device was still the
	same (same INQUIRY data, same device type, same LUNs, same total 
	capacity);

	The gendisk driver would have to verify that the partition table
	was still the same;

	The filesystem driver would have to verify that the filesystem was
	still the same (same superblock, journal file ends in the same
	place, maybe also some other checksums of important data 
	structures).

In the end, this could affect all the transport drivers and all the
filesystem drivers.  Of course, it's not necessary to do _all_ of them --
we can be conservative and assume that the device has changed if the
necessary verification routines don't exist.

Andrew Morton pointed out that some of this work could be performed in
userspace instead of in the kernel.  It's still a lot of work, and even
just exporting to userspace the data needed for doing the checking would
be nontrivial.

Alan Stern


--===============21454375792857094==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21454375792857094==--
