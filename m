From: "Ai Li" <aili@codeaurora.org>
Subject: platform specific pm_qos parameters
Date: Fri, 18 Dec 2009 18:51:38 -0700
Message-ID: <000601ca804d$ce010190$6a0304b0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

We are interested in using pm_qos_params to reduce power consumption
on our embedded devices while maintaining satisfactory performance.
One example of the QoS parameters is bus bandwidth.  We want to slow
down the buses dynamically to a lower level and yet provide enough
bandwidth to the system.

On our devices, different product families can have different type of
buses and different number of buses.  I remember that folks were
asking about platform specific pm_qos parameters some time ago.  It
seems a natural fit for us to create a different set of bandwidth QoS
for each platform.

I haven't seen much discussion recently on platform specific
pm_qos_params.  Are people still open to the idea?  I also would like
to help working on it.

~Ai
