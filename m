From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 22:59:56 +0200
Message-ID: <200504072259.56759.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30827550038220397=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============30827550038220397==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 7 of April 2005 22:00, Alan Stern wrote:
> On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:
> 
> > > It's very simple.  Processes in TASK_UNINTERRUPTIBLE can't be put in the
> > > refrigerator, so you have to wait until they can be put there.
> > 
> > It seems that if a process calls wait_for_completion() right before suspend,
> > the other task supposed to complete its completion may be accidentally frozen
> > before it's able to do this.  It looks like this happens to kseroid sometimes
> > on suspend-during-resume.
> 
> You mean, when a suspend occurs so soon after a resume that the resume has 
> fully completed yet?

No.

During resume, we boot the kernel, check if there's an image to read and
(if there's one) we freeze processes using the refrigerator (we need to get rid
of them so that we can restore the image safely).  Then, it seems, on
some systems, freeze_processes() may be called before all of the compiled-in
drivers complete their initialization.  In particular, kseriod calls usermodehelper
at that time, which makes it wait uninterruptibly for a helper process to
complete.  If that helper process is frozen, we end up with the uninterruptible
kseriod that we can't freeze and _resume_ fails, which is not nice, especially
that we don't need to care for this kseriod, as we are going to restore
the image in a while ...

Perhaps we should not use the refrigerator during resume, or we could use a
slightly modified version?  I don't know.

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============30827550038220397==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============30827550038220397==--
