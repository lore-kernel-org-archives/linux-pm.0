From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH v4] pm_qos: make update_request non blocking
Date: Mon, 14 Jun 2010 17:20:57 +0200
Message-ID: <20100614172057.778a49d0__33346.0294911221$1276528985$gmane$org@schatten.dmk.lab>
References: <1276097381-3982-1-git-send-email-florian@mickler.org>
	<1276097832.4343.223.camel@mulgrave.site>
	<20100609180033.39d5b499@schatten.dmk.lab>
	<1276099645.4343.257.camel@mulgrave.site>
	<20100609183204.1eeca494@schatten.dmk.lab>
	<1276103149.4343.350.camel@mulgrave.site>
	<20100610094525.0449d797@schatten.dmk.lab>
	<1276177144.27283.37.camel@mulgrave.site>
	<20100610164118.15ec7a05@schatten.dmk.lab>
	<1276266352.2862.70.camel@mulgrave.site>
	<20100614163339.755a2b5b@schatten.dmk.lab>
	<1276526646.5374.8.camel@mulgrave.site>
	<20100614164948.3b39d550@schatten.dmk.lab>
	<1276528206.5374.24.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276528206.5374.24.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: markgross@thegnar.org, Frederic Weisbecker <fweisbec@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linville@tuxdriver.com, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Jun 2010 10:10:06 -0500
James Bottomley <James.Bottomley@suse.de> wrote:
 
> On closer inspection, it looks like the
> notifier mutexes are sufficient to make sure it doesn't return running
> the notifier to be removed ... but that does mean that add and remove
> require user context.
> 
> James
> 

Yes. I don't think we need to make the add and remove callable from
interrupt context?

Cheers,
Flo
