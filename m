From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] PCI PM: Read device power state from
 register after updating it (rev. 2)
Date: Tue, 22 Sep 2009 09:16:20 +0200
Message-ID: <20090922091620.599ab046__8968.30341448567$1253603940$gmane$org@infradead.org>
References: <200909212337.01812.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909212337.01812.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Sep 2009 23:37:01 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>  
> -	dev->current_state = state;
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> +	/* Return error code if we have failed to change the state */
> +	if (dev->current_state != state)
> +		dev_info(&dev->dev, "Refused to change power state, "
> +			"currently in D%d\n", dev->current_state);

I would suspect that you want this message only once...
to avoid it flooding logs and such

or at least ratelimiting it


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
