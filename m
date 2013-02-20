From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] vt: add init_hide parameter to suppress boot output
Date: Tue, 19 Feb 2013 17:45:12 -0800
Message-ID: <20130220014512.GC31018@kroah.com>
References: <1361289224-10678-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361289224-10678-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Andy Ross <andy.ross@windriver.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 19, 2013 at 05:53:44PM +0200, Kirill A. Shutemov wrote:
> From: Andy Ross <andy.ross@windriver.com>
> 
> When vt.init_hide is set, suppress output on newly created consoles until
> an affirmative switched to that console.  This prevents boot output from
> displaying (and clobbering splash screens, etc...) without disabling the
> console entirely.

What's wrong with the 'quiet' option we have?  And you forgot to
document this.

greg k-h
