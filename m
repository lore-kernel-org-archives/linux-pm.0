From: Minkyu Kang <promsoft@gmail.com>
Subject: Re: [PATCH v2] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 19:39:59 +0900
Message-ID: <1f3430fb0906040339j50e02e1w347b0fec05320cda__43034.4609696933$1244112059$gmane$org@mail.gmail.com>
References: <4A278C08.5000206@samsung.com>
	<20090604020624.4d39e0a3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090604020624.4d39e0a3.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> Wouldn't it be better to start the delayed_work after the
> power_supply_register() has succeeded?
>

Yes, that's better. thanks :)

-- 
from. prom.
promsoft.net
