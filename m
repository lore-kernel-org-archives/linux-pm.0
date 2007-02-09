From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: question on freeze and aio
Date: Fri, 9 Feb 2007 17:23:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0702091722370.4557-100000@iolanthe.rowland.org>
References: <1171058926.1484.74.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171058926.1484.74.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sat, 10 Feb 2007, Nigel Cunningham wrote:

> > aio callbacks are interrupt-driven and execute in a workqueue (see
> > fs/aio.c), and as far as I can tell that workqueue doesn't freeze.  =

> > Unless some general facility freezes all workqueues...
> =

> Hmm. That applies to Raid, too? I've had some reports of raid i/o being
> caught in the BUG_ON() I have to catch I/O that shouldn't be happening,
> but haven't gotten around to looking at them yet.

Sorry, I don't know how the RAID drivers work.

Alan Stern
