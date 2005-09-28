From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 17:13:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509281713010.5193-100000@iolanthe.rowland.org>
References: <20050928205147.GB2506@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============27233511789203124=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050928205147.GB2506@elf.ucw.cz>
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

--===============27233511789203124==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 28 Sep 2005, Pavel Machek wrote:

> > The problem that no pm_message_t is passed to resume routines.
> > 
> > Another solution would be to create a globally-available subroutine, 
> > something like:
> > 
> > 	int resuming_from_disk(void)
> 
> No. We do not have freezing_devices() nor suspending_devices(), and we
> should not have this one.

Well, it would be a lot easier than changing all the resume routines.

Do you have some reason for not allowing this?

Alan Stern


--===============27233511789203124==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============27233511789203124==--
