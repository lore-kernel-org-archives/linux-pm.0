From: "Ai Li" <aili@codeaurora.org>
Subject: adding handles to pm_qos?
Date: Wed, 14 Oct 2009 11:24:19 -0600
Message-ID: <000001ca4cf3$2a2da9c0$7e88fd40$@org>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

We are calling pm_qos from some of our drivers.  One concern is that
each call of pm_qos_update_requirement() iterates through the client
list and strcmp the client names.  It could be slow.  A proposal is
that pm_qos provides handles that can be used on
pm_qos_update_requirement().

For measurement purposes, I added get/put interfaces to
acquire/release the handles and a new pm_qos_update_requirement
function that bypasses the iteration and strcmp.  Here are some
collected data:

How many clock cycles does pm_qos_update_requirement take?
when there is one client on this qos_class:
    using handle        using name      using handle/using name
avg 252.4               400.4           63%

when there are 5 clients on this qos_class:
    using handle        using name      using handle/using name
avg 407.6               644.8           63%

when there are 10 clients on this qos_class:
    using handle        using name      using handle/using name
avg 582.4               938.4           62%

Given the time differences, it seems worthwhile to add handles.

~Ai
