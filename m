From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/2] PM / sleep: don't suspend parent when async child
 suspend_{noirq,late} fails
Date: Wed, 9 Nov 2016 16:18:07 -0800
Message-ID: <20161110001807.GA77056@google.com>
References: <1476923170-111986-2-git-send-email-briannorris@chromium.org>
 <8017823.VJuZzSqtaY@vostro.rjw.lan>
 <CAKdAkRS+uUrx72DLKuyDiUMkKzxMTRXx5Pv1JBky6T8huv4Fhg@mail.gmail.com>
 <50971906.K6xak2t6Z6@vostro.rjw.lan>
 <20161102050706.GA49402@google.com>
 <CAJZ5v0hpcH2-UYtFC5kPc1n-O40fTPwzoCgbboOqfYMOGDXj7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hpcH2-UYtFC5kPc1n-O40fTPwzoCgbboOqfYMOGDXj7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chuansheng Liu <chuansheng.liu@intel.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 01:08:56AM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 2, 2016 at 6:07 AM, Brian Norris <briannorris@chromium.org> wrote:
> > I can test this and send it in proper form if that looks preferable.
> 
> It does to me as per the discussion at the LPC.
> 
> Are you still going to submit it?

Yes, it just moved down my mental list of things. Will do today.
