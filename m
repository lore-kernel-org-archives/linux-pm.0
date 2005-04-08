From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: freeze_processes questions
Date: Fri, 8 Apr 2005 09:20:09 +0200
Message-ID: <20050408072008.GB1435@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504071031440.989-100000@ida.rowland.org>
	<200504072003.02105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============23239589309184483=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504072003.02105.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@cyclades.com>
List-Id: linux-pm@vger.kernel.org

--===============23239589309184483==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > OTOH... we may want to move completely away from refrigerator. Its
> > > > quite a hack, and it device support is okay, we'll not really need it.
> > > 
> > > Still, it won't happen soon, I guess. :-)  As of today, we have the
> > > refrigerator and the processes in TASK_UNINTERRUPTIBLE are mishandled.
> > > I think we should do something about it, at least for now, until we drop
> > > the refrigerator altogether (if we are going to drop it).  That's why I
> > > started the discussion and sent the patch.
> > 
> > It's very simple.  Processes in TASK_UNINTERRUPTIBLE can't be put in the
> > refrigerator, so you have to wait until they can be put there.
> 
> It seems that if a process calls wait_for_completion() right before suspend,
> the other task supposed to complete its completion may be accidentally frozen
> before it's able to do this.  It looks like this happens to kseroid sometimes
> on suspend-during-resume.

Hmm, so maybe rule needs to be "other tasks may not be waiting on you
using wait_for_completion when you enter refrigerator?
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============23239589309184483==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============23239589309184483==--
