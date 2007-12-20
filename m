From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: OOPS: 2.6.24-rc5-mm1 -- EIP is at r_show+0x2a/0x70
 -- (triggered by "cat /proc/iomem" AFTER suspend-to-disk/resume)
Date: Thu, 20 Dec 2007 09:32:06 -0800
Message-ID: <20071220093206.22f319b0.akpm__26375.2945502803$1198172060$gmane$org@linux-foundation.org>
References: <a44ae5cd0712192040k7480682eoa29f33d70a91c618@mail.gmail.com>
	<4769F409.6030300@gmail.com> <4769FF37.5060308@gmail.com>
	<476A703B.50804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <476A703B.50804@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miles Lane <miles.lane@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@sgi.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Dec 2007 08:38:03 -0500 Miles Lane <miles.lane@gmail.com> wrote:

> On further investigation, "cat /proc/iomem" does not trigger the stack 
> trace until after a suspend-to-disk/resume cycle has occurred.

I still can't reproduce this.

Could you please try this?

- cat /proc/iomem
- suspend/resume
- do

while read i
do
echo $i
sleep 1
done < /proc/iomem

then, with luck, we'll be able to work out which /proc/iomem record
immediately precedes the corrupted one.
