From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Wed, 6 Apr 2011 06:23:35 +0100
Message-ID: <20110406052335.GA25578__18358.8705178865$1302067570$gmane$org@sirena.org.uk>
References: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
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
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 04, 2011 at 08:47:01PM -0700, Sonny Rao wrote:
> This improves our resume time when we have devices on an i2c bus
> that are slow to resume.  In particular we have a light sensor that
> adds about 50ms of resume time on one device. We have to enable it
> both on the i2c master and i2c client side and then we get fully async
> suspend/resume.  I suspect we'll see nice gains on systems with more
> i2c devices and will test that out soon.
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

It'd probably help if the patch explained why this is safe - my
immediate question is why if it's safe to just unconditionally enable
async suspend for all I2C clients and adaptors it's not safe to do so
for all devices of all types?
