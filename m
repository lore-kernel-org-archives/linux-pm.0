From: "Du, Alek" <alek.du@intel.com>
Subject: Re: [PATCH v2] [RFC] ehci: Disable wake on overcurrent
 (WKOC_E) and disconnect (WKDISC_E)
Date: Wed, 12 May 2010 00:10:54 +0800
Message-ID: <1865303E0DED764181A9D882DEF65FB61A82CECA8A__9462.08031750775$1273594324$gmane$org@shsmsx502.ccr.corp.intel.com>
References: <20100511113120.02787f96@dxy2>
	<Pine.LNX.4.44L0.1005111156150.1834-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005111156150.1834-100000@iolanthe.rowland.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Tuesday, May 11, 2010 11:58 PM
>To: Du, Alek
>Cc: Ondrej Zary; Linux-pm mailing list; USB list; Kernel development list
>Subject: Re: [linux-pm] [PATCH v2] [RFC] ehci: Disable wake on overcurrent
>(WKOC_E) and disconnect (WKDISC_E)
>
>Alek:
>
>By the way, does the Moorestown platform support multiple ports
>on the root hub?  If it does then using a single time delay (instead of
>a separate delay for each port) makes sense.  But if it doesn't then
>there's no reason to move the power-up and power-down delays outside
>the port loops.
>
>Alan Stern

Alan,

Yes, the Moorestown platform supports multi-ports, actually my test board has three ports on the root hub.

Thanks,
Alek
