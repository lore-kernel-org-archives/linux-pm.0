From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 6 Jul 2006 15:31:19 -0700
Message-ID: <20060706223119.GA3135@kroah.com>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060629030923.GA18968@kroah.com>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607061527.29421.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 06, 2006 at 03:27:28PM -0700, David Brownell wrote:
> The only other new behaviors of note are that the console changes now
> prevent diagnostics during suspend (sigh), and that something (maybe
> the PM_TRACE stuff?) is causing a 60 GB ext3 filesystem to fsck on
> every reboot, claiming it's been 10+ years since it was last checked.

Yeah, the PM_TRACE stuff caused this for me too, and was driving me
crazy until I figured out what was killing my clock chip...

thanks,

greg k-h
