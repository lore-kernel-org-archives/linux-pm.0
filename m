From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/4] PM / core: Direct handling of DPM_FLAG_SMART_SUSPEND
 and DPM_FLAG_LEAVE_SUSPENDED
Date: Tue, 2 Jan 2018 10:57:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1801021053080.1633-100000@iolanthe.rowland.org>
References: <CAPDyKFqi0TgSwPzjfJj=6SEtk4uKUJhgM9ubyax4u-4aC5=Jfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqi0TgSwPzjfJj=6SEtk4uKUJhgM9ubyax4u-4aC5=Jfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2 Jan 2018, Ulf Hansson wrote:

> > While I acknowledge that Ulf doesn't appear to be convinced by my
> > arguments, I also see no technical reason why this cannot go in.
> 
> Correct, I am not convinced this is the right path as a general
> optimization, at least in it's current form. The main argument is
> about skipping invoking callbacks, as I have stated.
> 
> Moreover, I think we are lacking important input from some more
> experienced PM core code contributors, like Alan, Kevin etc. If any of
> those guys would give an ack, that would also make me more comfortable
> with this.
> 
> On the other hand, I realize that we can't wait forever for that to happen.

Sad to say, I have not been paying any significant attention to this 
patch series.  The major points I have gleaned are that these are all 
relatively small optimizations, and that by default the patches do not 
change existing behavior (they are opt-in).

So at first glance there's no pressing reason not to apply them.  But 
admittedly, this viewpoint ignores the larger picture.

Alan Stern
