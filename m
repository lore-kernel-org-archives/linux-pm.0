From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 22:51:47 +0200
Message-ID: <20050928205147.GB2506@elf.ucw.cz>
References: <200509282109.25419.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0509281528410.5193-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79114467718872894=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509281528410.5193-100000@iolanthe.rowland.org>
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
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============79114467718872894==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On St 28-09-05 15:31:36, Alan Stern wrote:
> On Wed, 28 Sep 2005, Rafael J. Wysocki wrote:
> 
> > > That's what it should do when resuming from disk.
> > > 
> > > But that's not what it should do when it's being resumed just after the
> > > memory image was created, in order to write out the image.  In this case
> > > the device is known to be in FREEZE, not SUSPEND, and to save time we
> > > would like the driver not to go through a full resume procedure.
> > > 
> > > The problem is that currently the driver has no way to tell the difference
> > > between the two types of resume.  What's needed is a way for driver to 
> > > tell, and that can be added easily enough.
> > 
> > Yes, I've been thinking about it for some time.  It seems to me we could do
> > this with the help of an additional field in pm_message_t.
> 
> The problem that no pm_message_t is passed to resume routines.
> 
> Another solution would be to create a globally-available subroutine, 
> something like:
> 
> 	int resuming_from_disk(void)

No. We do not have freezing_devices() nor suspending_devices(), and we
should not have this one.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============79114467718872894==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79114467718872894==--
