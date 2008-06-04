From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [QUESTION] How to reset TCP connections when
 resuming system from disk/ram
Date: Wed, 04 Jun 2008 18:41:29 +0300
Message-ID: <4846B7A9.4020904@gmail.com>
References: <200806020026.56875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806020026.56875.maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Maxim Levitsky wrote:
> Hi,
> 
> Thanks to your effort, the suspend to ram/disk works flawlessly on my
> desktop system.
> 
> But I still have rather small, but annoying problem, that system doesn't
> understands that a long suspend cycle was done, and still waits for long closed
> TCP connections.
> 
> I remember there was a patch to close all TCP connections on suspend, but it was rejected
> due to the fact that TCP sessions can live through short suspend/resume cycles.
> 
> What can you suggest here?
> Is there a tool to close all TCP connections?
> 
> I noticed that sockets aren't dependent on network drivers, 
> so even removing network driver doesn't close them.
> ( I guess that it is possible for TCP session to migrate from one to another
> network hardware too)
> 
> 
> Another thing I want to know, is this possible to set socket timeout
> and how? 
> 
> (There is a settings page for that in KDE, but I don't yet know what this changes,
> a KDE specific settings or not)
> 
> I want something CLI based.
> 
> 
> Btw, I recently bought an acer laptop (5720G), and there are few suspend/resume issues,
> namely:
> 
> *attempt to do a second suspend to ram freezes the system hard on resume.
> for example this works:
> 
> suspend to ram
> suspend to disk
> suspend to ram
> suspend to disk
> 
> but this doesn't
> 
> suspend to ram
> suspend to ram
> 
> Best regards,
> 	Maxim Levitsky


Meanwhile I found a tcpkill utility,
but doesn't do what I want, since this tool gets a list of TCP
connections by sniffing network traffic, thus it can't detect
all connections during suspend.

Any ideas?

Best regards,
	Maxim Levitsky
