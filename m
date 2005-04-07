From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 23:03:15 +0200
Message-ID: <200504072303.15502.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28513577988681771=="
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@cyclades.com>
List-Id: linux-pm@vger.kernel.org

--===============28513577988681771==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 7 of April 2005 22:00, Alan Stern wrote:
> On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:
]--snip--[ 
> > > If that means waiting more than 10 seconds or so, you should just give up.  
> > > Return an error and put a message in the log saying something like "Can't
> > > suspend because process XXX is busy".
> > 
> > OK, that's what we do now.  Except that IMO we should clear the PF_FREEZE flag
> > for this process and do recalc_sigpending() for it after we give up, because
> > otherwise it will enter the refrigerator sooner or later and it will stay there.
> > Alternatively, we can disable the "freezing loop" in refrigerator() as soon as
> > thaw_processes() is started.  Also, we can avoid setting PF_FREEZE for
> > processes in TASK_UNINTERRUPTIBLE, but count them as "freezable".  Etc.
> 
> Yes, all the necessary cleanup steps should be taken.

Pavel, which approach do you like most?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============28513577988681771==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28513577988681771==--
