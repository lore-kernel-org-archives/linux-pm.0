From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 10:43:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0504071041240.989-100000@ida.rowland.org>
References: <1112825259.3757.82.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36037714046025338=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112825259.3757.82.camel@desktop.cunningham.myip.net.au>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============36037714046025338==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 7 Apr 2005, Nigel Cunningham wrote:

> Whenever this topic comes up, the discussion is always abstract. If
> someone could think of a lock that might actually deadlock suspending,
> we look seriously at the issue. In the meantime, all I can say, from
> roughly three years of developing and testing, is that it never seems to
> happen. And yes, I know that doesn't necessarily mean it can't.

I agree with Nigel.  Certainly in the USB part of the kernel the
uninterruptible sleeps all have rather short, bounded durations.  
Furthermore they correspond to specific events -- a new device is plugged
in -- which are unlikely to occur just as the system is going to sleep.

Alan Stern


--===============36037714046025338==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36037714046025338==--
