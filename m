From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: simpler calculation of number of pages
	in PBE list
Date: Sat, 30 Jul 2005 15:32:58 +0200
Message-ID: <200507301532.59576.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0507292126390.16749-100000@netrider.rowland.org>
	<200507301516.32003.rjw@sisk.pl> <20050730131356.GE1830@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050730131356.GE1830@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Saturday, 30 of July 2005 15:13, Pavel Machek wrote:
> Hi!
> 
> > > 	px >= n + x
> > > 
> > > or
> > > 
> > > 	(p-1)x >= n
> > > 
> > > or
> > > 
> > > 	x >= n / (p-1).
> > > 
> > > The obvious solution is
> > > 
> > > 	x = ceiling(n / (p-1)),
> > > 
> > > so calc_nr should return n + ceiling(n / (p-1)), which is exactly what 
> > > Michal's patch computes.
> > 
> > Nice. :-)
> > 
> > Could we perhaps add your proof to the Michal's patch as a comment,
> > for reference?
> 
> No, thanks. It only proves that it is equivalent to old code, but says
> nothing about quality of code, and we really do not want to keep old
> code around.

IMHO it rather says that the formula is OK and would save some time to
people reading the code for the _first_ time and trying to understand it,
but you decide. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
