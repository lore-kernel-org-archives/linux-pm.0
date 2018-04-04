From: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH V3] PM / core: fix deferred probe breaking suspend resume
 order
Date: Wed, 4 Apr 2018 14:10:41 -0700
Message-ID: <CAL85gmBtFnXje9tPngXEyCCwuvxvH6YHB=HrvjfU7npPDiSTCw@mail.gmail.com>
References: <1520274579-30492-1-git-send-email-fkan@apm.com>
 <CAL85gmAAVoCCXoLH+c0ROSBy4mS3z86tnbX+7Avh5oGT=fHcfA@mail.gmail.com>
 <20180330225024.GH9322@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180330225024.GH9322@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Toan Le <toanle@apm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 30, 2018 at 3:50 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Mar 15, 2018 at 11:41:33AM -0700, Feng Kan wrote:
>> On Mon, Mar 5, 2018 at 10:29 AM, Feng Kan <fkan@apm.com> wrote:
>> > When bridge and its endpoint is enumerated the devices are added to the
>> > dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
>> > This causes the bridge to be moved to the end of the dpm list when
>> > deferred probe kicks in. The order of the dpm list for bridge and
>> > endpoint is reversed.
>> >
>> > Add reordering code to move the bridge and its children and consumers to
>> > the end of the pm list so the order for suspend and resume is not altered.
>> > The code also move device and its children and consumers to the tail of
>> > device_kset list if it is registered.
>> >
>> > Signed-off-by: Feng Kan <fkan@apm.com>
>> > Signed-off-by: Toan Le <toanle@apm.com>
>> > ...
>> >
>> Hi, just wanted to check if there is anything else I need to change on
>> this. Thanks.
>
> I'm assuming Rafael will handle this.
Rafael, sorry to ping again. Do you have a position on this patch yet?
