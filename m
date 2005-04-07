From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 19:26:18 +0200
Message-ID: <200504071926.18787.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504071041240.989-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============95220483769723807=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0504071041240.989-100000@ida.rowland.org>
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
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============95220483769723807==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 7 of April 2005 16:43, Alan Stern wrote:
> On Thu, 7 Apr 2005, Nigel Cunningham wrote:
> 
> > Whenever this topic comes up, the discussion is always abstract. If
> > someone could think of a lock that might actually deadlock suspending,
> > we look seriously at the issue. In the meantime, all I can say, from
> > roughly three years of developing and testing, is that it never seems to
> > happen. And yes, I know that doesn't necessarily mean it can't.
> 
> I agree with Nigel.  Certainly in the USB part of the kernel the
> uninterruptible sleeps all have rather short, bounded durations.  
> Furthermore they correspond to specific events -- a new device is plugged
> in -- which are unlikely to occur just as the system is going to sleep.

Strangely enough, I agree with him too. :-)  Still, Nigel says he is handling
uninterruptible tasks in the way that I was thinking of (as far as I
understand it), which you say is a mistake ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============95220483769723807==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============95220483769723807==--
