From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Tue, 5 Apr 2005 20:33:23 +0200
Message-ID: <200504052033.23978.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504051416530.707-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============84734305932789256=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0504051416530.707-100000@ida.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============84734305932789256==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, 5 of April 2005 20:17, Alan Stern wrote:
> On Tue, 5 Apr 2005, Rafael J. Wysocki wrote:
> 
> > 1) We can treat uninterruptible tasks as non-freezable (in analogy to stopped
> > tasks) - if all of the other tasks are frozen, nothing can wake up an uninterruptible
> > task, so this seems to be a safe approach.
> 
> Not true at all.  An uninterruptible task can be woken up by an interrupt 
> handler.

Right.  So it seems we'll have to force uninterruptible tasks to go to the
refrigerator().

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============84734305932789256==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============84734305932789256==--
