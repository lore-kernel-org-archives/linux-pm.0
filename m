From: Poussa Sakari <sakari.poussa@nokia.com>
Subject: Re: Ottawa Linux Power Management Summit
Date: Thu, 24 May 2007 09:49:46 +0300
Message-ID: <1179989386.6603.10.camel@esdhcp04155.research.nokia.com>
References: <200705112313.54744.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705112313.54744.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, "Pedersen Klaus.K (Nokia-M/Helsinki)" <klaus.k.pedersen@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-05-11 at 23:13 -0400, ext Len Brown wrote:
> Please let me know what you think should be on the agenda,
> and if you are motivated to show up for the discussion.

Below is our proposed topics to the agenda. We could also give a short
presentation about latest developments in Nokia N800 power management
area. 

BTW, we in this context mean people involved in Nokia Internet Tablet
power management development (Igor, Klaus and myself).

- Presentation of DVFS in Nokia N800 including
  - integration with clock framework and needed enhancements
  - role of the voltage and other frameworks

- Future power management challenges in Nokia Internet Tablets
  - next omap and new requirements 
  - power aware applications and policies
  - pm interface between kernel and pm aware applications

- Current budgeting in embedded USB host
  - how to balance the current flow from battery to usb peripheral
 
- How to use the clk fw to express constraints
  - between clocks
  - between clocks and voltages

- How to address power domains with timeouts
  - simple bitfields management example

Regards,
	Sakari Poussa
