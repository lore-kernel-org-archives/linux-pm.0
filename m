From: Paul Menage <menage@google.com>
Subject: Re: [RFC][PATCH] freezer_cg: disable writing
	freezer.state of root cgroup
Date: Wed, 5 Nov 2008 16:48:26 -0800
Message-ID: <6599ad830811051648i72c2c585s4ee803e030c798ad__42537.3894432143$1225932790$gmane$org@mail.gmail.com>
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
Cc: Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 4, 2008 at 12:01 AM, Li Zefan <lizf@cn.fujitsu.com> wrote:
> Paul Menage wrote:
>> On Mon, Nov 3, 2008 at 11:35 PM, Li Zefan <lizf@cn.fujitsu.com> wrote:
>>> With this change, the root cgroup is unfreezable, and writing to
>>> its freezer.state returns -EIO.
>>
>> EINVAL might be more consistent with other systems like cpusets.
>>
>
> Because writing FREEZE (or other invalid value) to freezer.state returns EIO..
>
> Or that EIO should be also changed to EINVAL.

Yes, I think that should be EINVAL too - seems more consistent.

Paul
