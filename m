From: Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during suspend
Date: Thu, 2 Sep 2010 22:52:56 +0200
Message-ID: <AANLkTi==kpbcJQ9E_MMfs9Ohu_O4vNsf8T7NK1z+iAwn@mail.gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com>
	<4C7F6931.4050707@gmail.com>
	<4C7F7649.3010409@gmail.com>
	<201009021633.22869.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201009021633.22869.stephan.diestelhorst@amd.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 2, 2010 at 4:33 PM, Stephan Diestelhorst
<stephan.diestelhorst@amd.com> wrote:
> On Thursday 02 September 2010, 12:02:49 Tejun Heo wrote:
>> For some mysterious reason, certain hardware reacts badly to usual E=
H
>> actions while the system is going for suspend. =A0As the devices won=
't
>> be needed until the system is resumed, ask EH to skip usual autopsy
>> and recovery and proceed directly to suspend.
>
> Thanks Tejun for this patch. Will test in a second!

Applied, compiled and worked for the 5 iterations I managed to test it.
Much better than your previous patch, thanks a lot! I'd give it some mo=
re spins
tomorrow, though.


Thanks,
  Stephan
