From: Tom Lyon <pugs@cisco.com>
Subject: question about driver's runtime_suspend
Date: Fri, 3 Sep 2010 15:20:19 -0700
Message-ID: <201009031520.19452.pugs@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: rjw@sisk.pl, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi. I am looking at supporting the new PM stuff in my VFIO "driver" - which 
allows user level drivers for PCI* devices.

When runtime_suspend is invoked, is it allowed to sleep while determining 
whether the device can be suspended?  If not, does returning -EAGAIN mean that 
it will be called again after some interval? 

I would like to notify the user level that a suspend is desired, and then wait 
for it to tell the vfio driver whether or not the suspend is OK.

Thanks for any help.
