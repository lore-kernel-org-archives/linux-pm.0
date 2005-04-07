From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 19:17:06 +0200
Message-ID: <200504071917.07198.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504071039550.989-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30853674260143404=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0504071039550.989-100000@ida.rowland.org>
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
Cc: ncunningham@cyclades.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============30853674260143404==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 7 of April 2005 16:41, Alan Stern wrote:
> On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:
> 
> > Well, (having thought about it for a while) why, actually, a device's _suspend()
> > routine would need such a lock?  Devices are suspended on one CPU in
> > a single thread which can only (potentially) race with interrupt handlers ...
> 
> You're blinded by thinking that suspend() can be called only during a 
> system sleep transition.

Well, yes. :-)

> Don't forget about runtime power management! 

Of course you're right.  Thanks for pointing this out.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


--===============30853674260143404==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============30853674260143404==--
