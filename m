From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: extend linux pm proposal
Date: Fri, 03 Apr 2009 11:52:26 +0200
Message-ID: <49D5DC5A.8040002@gandalf.sssup.it>
References: <49D5BC68.4020602@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49D5BC68.4020602@gandalf.sssup.it>
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

Hi,
Michael Trimarchi wrote:
> Hi all,
>
> I would like to exetend the pm api, adding the possibilty to remove a 
> device to the pm_list, with
> its child, so it is possible to select the devices to suspend. I take a 
> look at the struct
> and I don't find the child list pointers, but only the parent. This 
> possiblity can be usefull in cases that the system go to suspend but the 
> hardware needs some devices used by onother subsystem.
>   
Sorry I find howto move throw the child.
> So adding a tree view of the dependences can give the possibility to 
> remove from suspend list
> a entire subtree.
>
> device A < device_pm_remove call by user space remove the C and D device
>    |
>    \--------device C
>    |
>    \--------device D
>
> Regards Michael
>   
Michael
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
>   
