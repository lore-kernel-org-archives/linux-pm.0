From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from
 PM operations
Date: Wed, 22 Dec 2010 20:14:14 +0000
Message-ID: <20101222201413.GB8167__26572.9724000723$1293048905$gmane$org@opensource.wolfsonmicro.com>
References: <1293041268-7707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTin5eSg8vL4Q8yZ9tme38fbS2aAZ-xeLQSNu809B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTin5eSg8vL4Q8yZ9tme38fbS2aAZ-xeLQSNu809B@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rabin Vincent <rabin@rab.in>
Cc: Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 23, 2010 at 12:49:39AM +0530, Rabin Vincent wrote:

> And even if we did want to support runtime PM interaction for legacy
> ops, the code for restore() above suffers from the problem of setting
> active even when no callback exists, like I mentioned in the same email
> for resume():

I agree it's confused, I posted an updated patch which should behave
exactly as the old code did - I think the confusion with the legacy
behaviour should be addressed seperately (and ideally in 2.6.37 or at
least a stable patch rather than 2.6.38 which is where the current patch
is targetted).
