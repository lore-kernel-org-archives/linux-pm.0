From: Pavel Machek <pavel@ucw.cz>
Subject: Re: freeze_processes questions
Date: Tue, 5 Apr 2005 11:27:42 +0200
Message-ID: <20050405092742.GA1327@elf.ucw.cz>
References: <200504051120.44496.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============97114018290219684=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504051120.44496.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============97114018290219684==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> 
> I have two questions regarding freeze_processes():
> 
> 1) Shouldn't we take the TASK_UNINTERRUPTIBLE state into consideration?  Now
> we will fail if a process is sleeping when we try to freeze it.

We can't allow processes to sleep at arbitrary places. Therefore we
send UNINTERRUPTIBLE task a signal, and hope it can get into
refrigerator in time.

> 2) Is it necessary to check p->state == TASK_STOPPED and
> p->state == TASK_TRACED twice in a row (once in freezable() and
> then again in the next if ())?

Those tests should probably be killed from if() below. As far as I can
see, they can not trigger there.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============97114018290219684==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============97114018290219684==--
