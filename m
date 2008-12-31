From: Bob Copeland <me@bobcopeland.com>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Wed, 31 Dec 2008 18:26:09 -0500
Message-ID: <20081231232609.GA27391__967.919376171444$1230766256$gmane$org@hash.localnet>
References: <348894.23448.qm@web23108.mail.ird.yahoo.com>
	<495B82CB.6050205@tuffmail.co.uk>
	<495BC8F9.4040203@lwfinger.net> <495BF975.7030603@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <495BF975.7030603@lwfinger.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, htl10@users.sourceforge.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 31, 2008 at 05:00:05PM -0600, Larry Finger wrote:
> +#ifdef CONFIG_PM
> +
> +static int rtl8187_suspend(struct usb_interface *intf, pm_message_t
> state)
> +{
> +	struct ieee80211_hw *dev = usb_get_intfdata(intf);
> +
> +	rtl8187_stop(dev);
> +
> +	return 0;
> +}

Won't this do the wrong thing if the interface is never brought up
before you do suspend?  (And then you can add a flag etc. to handle
that case, but that's exactly what my mac80211 patches aim to do.)

-- 
Bob Copeland %% www.bobcopeland.com
