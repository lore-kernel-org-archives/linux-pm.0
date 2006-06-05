From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [patch/rft 2.6.17-rc2] swsusp
	resume must not device_suspend()
Date: Mon, 5 Jun 2006 08:31:44 -0700
Message-ID: <200606050831.45464.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200605261719.57601.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060527163837.GE4242@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Saturday 27 May 2006 9:38 am, Pavel Machek wrote:

> Okay, you are right that suspend and freeze are similar, too. Can you
> retransmit the patch?

What I'll do is post the whole series, of which that one interface
patch was just the interface change that I thought was worth a bit
of separate discussion.  They'll be in the next messages from me,
against 2.6.17-rc5-git11 or so ... going only to linux-pm, but I'll
send a note with archive URLs to linux-usb-devel.

- Dave
