From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 15:06:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
References: <1112742641.3757.58.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41740361469218534=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112742641.3757.58.camel@desktop.cunningham.myip.net.au>
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

--===============41740361469218534==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 6 Apr 2005, Nigel Cunningham wrote:

> I don't think Rafael is suggesting ignoring them. He's suggesting what
> I'm already doing:
> - Signal so they enter the freezer if they leave the state;
> - Don't count them when deciding whether freezing failed;
> - Handle the case where they don't leave the state until post resume (I
> let them enter the refrigerator, but have code in there to check whether
> the freezer is still on).
> 
> In this way, I handle kseriod and anything else uninterruptible without
> any problems.

What happens if a process owns a lock needed to suspend a device and it is 
waiting in TASK_UNINTERRUPTIBLE?

Alan Stern


--===============41740361469218534==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41740361469218534==--
