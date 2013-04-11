From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [v2,01/14] thermal: Rename driver 'kirkwood' -> 'mvebu'
Date: Thu, 11 Apr 2013 14:47:27 -0400
Message-ID: <5167053F.70709@ti.com>
References: <1363991114-4225-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <5166DE30.3020001@ti.com> <20130411163156.GB2279@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130411163156.GB2279@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 11-04-2013 12:31, Ezequiel Garcia wrote:
> Hi Eduardo,
>
> Thanks for your testing.
>
> On Thu, Apr 11, 2013 at 12:00:48PM -0400, Eduardo Valentin wrote:
>> Hello Ezequiel,
>>
>> Two minor comments.
>>
>> On 22-03-2013 18:25, Ezequiel Garcia wrote:
>>> This driver will support several Marvell SoC, so it is convenient
>>> to rename it to 'mvebu' to represent accurately the hardware it
>>> supports.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>>
>>> ---
>>> .../bindings/thermal/kirkwood-thermal.txt          |   15 ---
>>>    .../devicetree/bindings/thermal/mvebu-thermal.txt  |   15 +++
>>>    drivers/thermal/Kconfig                            |   10 +-
>>>    drivers/thermal/Makefile                           |    2 +-
>>>    drivers/thermal/kirkwood_thermal.c                 |  134 --------------------
>>>    drivers/thermal/mvebu_thermal.c                    |  134 ++++++++++++++++++++
>>>    6 files changed, 155 insertions(+), 155 deletions(-)
>>>    delete mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
>>>    create mode 100644 Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
>>>    delete mode 100644 drivers/thermal/kirkwood_thermal.c
>>>    create mode 100644 drivers/thermal/mvebu_thermal.c
>>
>> When sending renames, use git format-patch --find-renames. The summary
>> will be much descriptive on what you have done.
>>
>
> Yes, you're right I forgot about this.
>
>> I tried applying this patch on top of linux-next, linus/master,
>> ruis/thermal, on top of the your suggested dependencies, and all failed.
>> What is your base?
>>
>
> Well, first of all this patchset has been dropped entirely after some discussion.
> If you're interested in this discussion you can read:
>
>    http://www.spinics.net/lists/arm-kernel/msg231697.html
>
> If you still want to try this series, the easiest way is to try
>
>    https://github.com/MISL-EBU-System-SW/mainline-public/commits/mvebu-thermal-v2
>
> That branch is based on v3.9-rc2, with a bunch of patches applied as
> explained in the cover letter.
>
> I appreciate your feedback a lot, but this are really ancient patches!
> You came in a little late :)


OK. Thanks for updating me. On the other hand. Some of your patches are 
still applicable. Can you please resend them based on kirkwood file still?

>
