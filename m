From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Thu, 7 Apr 2011 10:33:38 +0200
Message-ID: <20110407103338.5da7c092__30274.5188506835$1302165274$gmane$org@endymion.delvare>
References: <20110406095240.410b4e7e@endymion.delvare>
	<Pine.LNX.4.44L0.1104061043220.1907-100000@iolanthe.rowland.org>
	<20110406223123.GA5297@opensource.wolfsonmicro.com>
	<20110407095513.4c0b708e@endymion.delvare>
	<BANLkTikDc6QhtK6F5VTX4iCkT0CAiXvztg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikDc6QhtK6F5VTX4iCkT0CAiXvztg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 7 Apr 2011 01:19:59 -0700, Sonny Rao wrote:
> On Thu, Apr 7, 2011 at 12:55 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Sonny, I would expect you to obtain the time saving by only switching
> > the i2c client device to async suspend/resume. wasn't it the case? i2c
> > bus device suspend/resume shouldn't matter, as the operation should be
> > handled by the hardware (e.g. PCI) layer.
> 
> I tried that first, and it looked like the client resume wouldn't start on the
> async thread until the kernel resumed the i2c master which was

This is expected... You need an operational i2c master to talk to the
i2c client, regardless of async or not.

> happening very late for some reason.  Maybe this was just a fluke of
> the device ordering, but enabling it for both master and client allowed
> the device resume to consistently happen much earlier.

OK, that makes sense. I don't know how the synchronous resume decides
in which order it processes the devices, presumably it simply walks the
device tree. If you are unlucky and the i2c master is near the end,
then indeed the asynchronous resume of the i2c client device alone may
save nothing at all. I get it now.

-- 
Jean Delvare
