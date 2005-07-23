From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFT] solve "swsusp plays yoyo" with disks
Date: Sat, 23 Jul 2005 19:20:28 +0200
Message-ID: <200507231920.29336.rjw@sisk.pl>
References: <20050705172953.GA18748@elf.ucw.cz>
	<42DFBFA8.5060800@stud.feec.vutbr.cz>
	<20050721192015.GA6367@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60605845272921832=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050721192015.GA6367@atrey.karlin.mff.cuni.cz>
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
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============60605845272921832==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 21 of July 2005 21:20, Pavel Machek wrote:
> hi!
> 
> > >>I'd like to get this tested under as many configurations as
> > >>possible. With this, your hdd should no longer do "yoyo" (spindown,
> > >>spinup, spindown) during suspend...
> > >
> > >
> > >It looks like the patch is now in -mm (I use 2.6.13-rc3-mm1).
> > >But my disks still yoyo during suspend. What more is needed? Some patch 
> > >to ide-disk.c ?
> > 
> > I think I've found the problem.
> > The attached patch stops the disks from spinning down and up on suspend.
> > The patch applies to 2.6.13-rc3-mm1.
> > 
> > Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
> 
> Thanks, applied, I'll eventually propagate it.

FYI, tested and works (on 2.6.13-rc3). :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============60605845272921832==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60605845272921832==--
