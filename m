From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: freeze_processes questions
Date: Tue, 5 Apr 2005 14:17:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0504051416530.707-100000@ida.rowland.org>
References: <200504052002.30245.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37245835755721024=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504052002.30245.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============37245835755721024==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 5 Apr 2005, Rafael J. Wysocki wrote:

> 1) We can treat uninterruptible tasks as non-freezable (in analogy to stopped
> tasks) - if all of the other tasks are frozen, nothing can wake up an uninterruptible
> task, so this seems to be a safe approach.

Not true at all.  An uninterruptible task can be woken up by an interrupt 
handler.

Alan Stern


--===============37245835755721024==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37245835755721024==--
