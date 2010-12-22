From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] PM: Prototype the pm_generic_ operations
Date: Wed, 22 Dec 2010 11:43:16 +0000
Message-ID: <20101222114316.GA4520__43508.6560006768$1293018385$gmane$org@sirena.org.uk>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201012202208.59102.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201012202208.59102.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 20, 2010 at 10:08:58PM +0100, Rafael J. Wysocki wrote:

> I'd take this one, but the second one depends on it.

> I can take both if Jean agrees.

Given the nearness of the merge window another option is to apply this
one now and punt the I2C one until 2.6.38, I guess?
