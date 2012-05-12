From: Greg KH <greg@kroah.com>
Subject: Re: 3.3.5 regression: resume doesn't switch to X
Date: Sat, 12 May 2012 08:43:07 -0700
Message-ID: <20120512154307.GA6023@kroah.com>
References: <4FAE0E88.2030703@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FAE0E88.2030703@suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, May 12, 2012 at 09:17:28AM +0200, Jiri Slaby wrote:
> Hi,

<side note, it's stable@vger.kernel.org, not stable@kernel.org>

> since update to 3.3.5, my X doesn't show up after resume from
> hibernation anymore. The only thing I see is "resuming..." on the
> console. I can switch to any tty and login in text mode, but cannot
> switch to X despite it is running. I have to restart whole session to
> have X again.
> 
> Now I'm back to 3.3.4 and everything is OK.

Care to run 'git bisect' to find the offending patch?

thanks,

greg k-h
