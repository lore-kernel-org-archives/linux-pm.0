From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] power: supply: remove unused pointer 'dev'
Date: Wed, 29 Aug 2018 17:15:20 +0300
Message-ID: <20180829141520.vaiuepmjdvizzhh2@mwanda>
References: <20180828162842.17503-1-colin.king@canonical.com>
 <CAJKOXPcy3emsEPRRK+sKxe51ZWPoVscwHdrVz0fw7vJfLh9HWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPcy3emsEPRRK+sKxe51ZWPoVscwHdrVz0fw7vJfLh9HWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sameer Nanda <snanda@chromium.org>
Cc: colin.king@canonical.com, sre@kernel.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 29, 2018 at 03:54:13PM +0200, Krzysztof Kozlowski wrote:
> On Tue, 28 Aug 2018 at 18:29, Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Pointer 'dev' is being assigned but is never used hence it is
> > redundant and can be removed.
> >
> > Cleans up clang warning:
> > variable 'dev' set but not used [-Wunused-but-set-variable]
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/power/supply/cros_usbpd-charger.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> 
> Maybe add cros_usbpd prefix to the subject?
> 

Yeah.

The problem is that the prefix wasn't added to the subject in the
original commit f68b883e8fad ("power: supply: add cros-ec USBPD charger
driver.") which added the driver.  It's a common problem.  Normally what
happens is that someone adds a driver and then random static checker
people like Colin or I send the first fixes and we have no idea what the
correct prefix should be.  Anyway, checking the prefix is one of the
things we should look for when people add a new driver.

Also Colin you should CC Sameer because it's really his code.  Someone
should fix get_maintainer.pl so that it does git blame on the
lines before and after and adds people if the code is less than two
years old maybe.

regards,
dan carpenter
