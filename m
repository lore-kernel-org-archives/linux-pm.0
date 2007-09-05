From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Info on LDM, domain system and SOCs
Date: Wed, 05 Sep 2007 13:54:39 +0000
Message-ID: <46DEB51F.3010000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi all
I'm looking the Linux Driver Model (LDM) and the PM issues.

I see the LDM is only "bus-oriented".
Is there an "official" reason why it doesn't track clock and voltage?

In a SOCs usually there is more than one clock therefore it could be 
useful track not only the clock (as already done by the linux/clock.h) 
but also the relationship between clock-and-device.

For this reason I'm working on a generic framework domain (to track 
clocks and voltage with the same API) and the relationship between 
domains and devices.

The basic idea is something like:

struct device_driver {
    ...
    domain_ret_t (*domain_notifier)(struct domain_event * event, struct 
device* dev);
};

struct device {
    ...
    struct dev_dmn_info     clk;
    struct dev_dmn_info     vltg;
};

And in the future it tries to have a dynamic power management with all 
the info the system has on each device (bus_type, parent_device, 
clock_parent, voltage_parent).

Do you think is it a good idea? (if no why?)
Did somebody do something like that? (if no why?)

Ciao
 Francesco
