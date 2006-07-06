From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 6 Jul 2006 16:43:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607061642290.3869@g5.osdl.org>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060629030923.GA18968@kroah.com>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
	<20060706232710.GG30500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060706232710.GG30500@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Thu, 6 Jul 2006, Dave Jones wrote:
>
> On Thu, Jul 06, 2006 at 03:27:28PM -0700, David Brownell wrote:
>  > The only other new behaviors of note are that the console changes now
>  > prevent diagnostics during suspend (sigh)
> =

> That's the biggest step backwards we've made in power management
> in the last few years IMO.  What was the reasoning behind this change?

Now suspend actually _works_ for me with netconsole. Before, it very =

fundamentally wouldn't, it would panic left and right.

			Linus
