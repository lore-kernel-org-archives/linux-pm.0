From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [QUESTION] How to reset TCP connections when
 resuming system from disk/ram
Date: Wed, 04 Jun 2008 23:38:59 +0300
Message-ID: <4846FD63.9030208@gmail.com>
References: <Pine.LNX.4.44L0.0806041452590.4505-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0806041452590.4505-100000@iolanthe.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote:
> On Wed, 4 Jun 2008, Maxim Levitsky wrote:
> 
>> Maxim Levitsky wrote:
>>> Hi,
>>>
>>> Thanks to your effort, the suspend to ram/disk works flawlessly on my
>>> desktop system.
>>>
>>> But I still have rather small, but annoying problem, that system doesn't
>>> understands that a long suspend cycle was done, and still waits for long closed
>>> TCP connections.
>>>
>>> I remember there was a patch to close all TCP connections on suspend, but it was rejected
>>> due to the fact that TCP sessions can live through short suspend/resume cycles.
>>>
>>> What can you suggest here?
>>> Is there a tool to close all TCP connections?
> 
> I don't know the answer to your question.
> 
> However you should note that closing all TCP connections is overkill.  
> It's quite possible that some processes on your computer are 
> communicating among themselves using TCP; there's no reason those 
> connections should be killed.
Thanks a lot for the pointer, I agree completely
I guess such connections can be filtered by filtering out
connections with all local addresses (localhost, and each nic address)

When I have time I will probably write such a tool
(I need to look at /proc/net/.. for list of open TCP sockets,
and then I need to send RST to both ends of those sockets).

I can even parse netstat output for list of open sockets.

> 
> Alan Stern
> 

Thanks a lot,
	Best regards,
		Maxim Levitsky
