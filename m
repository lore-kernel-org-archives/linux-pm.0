From: Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [RFC][PATCH] freezer_cg: disable writing
 freezer.state of root cgroup
Date: Wed, 05 Nov 2008 11:18:54 +0100
Message-ID: <4911730E.2050900__31353.740199893$1225880641$gmane$org@fr.ibm.com>
References: <20080811235323.872291138@us.ibm.com>	
	<20080811235325.121356317@us.ibm.com>	
	<6599ad830811032143h51eae533k5b0c17e65a7fa675@mail.gmail.com>	
	<490FE7B5.8020400@cn.fujitsu.com>	
	<6599ad830811032240n640f3fao48f1a9f05892b797@mail.gmail.com>	
	<490FFB56.7030300@cn.fujitsu.com>
	<6599ad830811032356g6827a97dq41dec492fed8de15@mail.gmail.com>
	<4910014F.4000808@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4910014F.4000808@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, "Serge E. Hallyn" <serue@us.ibm.com>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello !

>> Or maybe just skip populating the file entirely for the root cgroup?
>> It's not useful if it can't be written and always returns the same
>> value.
> 
> I thought about this. I'll see which way Matt and Cedric prefer.

I think that Paul's suggestion of disabling the root freezer makes sense.

Thanks,

C.
