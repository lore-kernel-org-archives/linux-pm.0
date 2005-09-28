From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 17:12:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509281710460.5193-100000@iolanthe.rowland.org>
References: <20050928205106.GA2506@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============98733505953533918=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050928205106.GA2506@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============98733505953533918==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 28 Sep 2005, Pavel Machek wrote:

> > But that's not what it should do when it's being resumed just after the
> > memory image was created, in order to write out the image.  In this case
> > the device is known to be in FREEZE, not SUSPEND, and to save time we
> > would like the driver not to go through a full resume procedure.
> 
> Do you have any driver which can save some significant ammount of time
> that way?

All USB devices require several 10's of milliseconds to resume.  Whether 
that amount is "significant" is a matter of personal opinion.

Alan Stern


--===============98733505953533918==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============98733505953533918==--
