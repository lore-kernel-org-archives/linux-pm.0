From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] pm_qos: make update_request callable
 from interrupt context
Date: Wed, 9 Jun 2010 11:46:27 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006091146010.2933__30292.3968215056$1276076938$gmane$org@localhost.localdomain>
References: <1276074915-26879-1-git-send-email-florian@mickler.org>
	<1276074915-26879-2-git-send-email-florian@mickler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276074915-26879-2-git-send-email-florian@mickler.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Frederic Weisbecker <fweisbec@gmail.com>, markgross@thegnar.org, linux-kernel@vger.kernel.org, james.bottomley@suse.de, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Jun 2010, florian@mickler.org wrote:

> The pm_qos framework has to guarantee atomic notifications so that
> drivers can request and release constraints at all times while no races
> occur.
> 
> In order to avoid implementing a secondary notification chain in which
> listeners might sleep, we demand that every listener implements it's
> notification so that it can run in interrupt context. The listener is in
> a better position to know if races are harmful or not.

That breaks existing notifiers.

Thanks,

	tglx
