From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] pm: Add runtime PM statistics to sysfs
Date: Fri, 9 Jul 2010 15:04:59 +0800
Message-ID: <AANLkTinJSHiDbAZJ6ga3AGNoZEFzyVPSrHkEocxa8M6N__34277.1354284652$1278659192$gmane$org@mail.gmail.com>
References: <20100708224837.6a18995b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100708224837.6a18995b@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2010/7/9 Arjan van de Ven <arjan@infradead.org>:
> From: Arjan van de Ven <arjan@linux.intel.com>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 8e258c7..dca597f 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -476,9 +476,15 @@ struct dev_pm_info {
> =A0 =A0 =A0 =A0enum rpm_request =A0 =A0 =A0 =A0request;
> =A0 =A0 =A0 =A0enum rpm_status =A0 =A0 =A0 =A0 runtime_status;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 runtime_error;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 active_jiffies;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 suspended_jiffies;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 accounting_timestamp;
> =A0#endif
> =A0};

USB subsystem has implemented the function already, and only two variables
are enough to do the statistics. Suggest you to make a reference to usb
implementation, maybe sizeof(unsigned long) bytes per device can be saved.

-- =

Lei Ming
