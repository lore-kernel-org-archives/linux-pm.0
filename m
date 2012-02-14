From: Sameer Nanda <snanda@chromium.org>
Subject: Re: [PATCH 2/2] r8169: transition to D0 state at shutdown
Date: Tue, 14 Feb 2012 10:37:38 -0800
Message-ID: <CANMivWbK8KcOUqwhFzaGDBLQR60U23bJ6=ykdDarriV29TxKmQ@mail.gmail.com>
References: <1329244275-28130-1-git-send-email-snanda@chromium.org> <CANMivWZqSNmh8BiZLi7bVw475-P-XkxPTx_eT3Lb5i87N3Krog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CANMivWZqSNmh8BiZLi7bVw475-P-XkxPTx_eT3Lb5i87N3Krog@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: romieu@fr.zoreil.com, "Rafael J. Wysocki" <rjw@sisk.pl>, hayeswang@realtek.com
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, Sameer Nanda <snanda@chromium.org>
List-Id: linux-pm@vger.kernel.org

=46ixed Rafael's email address.  Sorry about the dupe emails.

On Tue, Feb 14, 2012 at 10:33 AM, Sameer Nanda <snanda@chromium.org> wr=
ote:
> Fixed Francois Romieu's email address.
>
> On Tue, Feb 14, 2012 at 10:31 AM, Sameer Nanda <snanda@chromium.org> =
wrote:
>> With runtime PM, if the ethernet cable is disconnected, the device i=
s
>> transitioned to D3 state to conserve energy. If the system is shutdo=
wn
>> in this state, any register accesses in rtl_shutdown are dropped on
>> the floor.
>>
>> This patch transitions the device back to D0 state in rtl_shutdown i=
f
>> the device was runtime PM suspended. In addition, since runtiome PM
>> also mucks around with WOL options, the saved WOL options are also
>> restored in rtl_shutdown.
>>
>> Signed-off-by: Sameer Nanda <snanda@chromium.org>
>> ---
>> =C2=A0drivers/net/ethernet/realtek/r8169.c | =C2=A0 12 ++++++++++++
>> =C2=A01 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethe=
rnet/realtek/r8169.c
>> index a6921b7..4a894e6 100644
>> --- a/drivers/net/ethernet/realtek/r8169.c
>> +++ b/drivers/net/ethernet/realtek/r8169.c
>> @@ -691,6 +691,7 @@ struct rtl8169_private {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 intr_event;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 napi_event;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 intr_mask;
>> + =C2=A0 =C2=A0 =C2=A0 bool runtime_suspended;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mdio_ops {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*write)=
(void __iomem *, int, int);
>> @@ -4308,6 +4309,7 @@ static int rtl8169_open(struct net_device *dev=
)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl_hw_start(dev);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tp->saved_wolopts =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 tp->runtime_suspended =3D false;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_put_noidle(&pdev->dev);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl8169_check_link_status(dev, tp, ioaddr=
);
>> @@ -6106,6 +6108,7 @@ static int rtl8169_runtime_suspend(struct devi=
ce *device)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irq(&tp->lock);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tp->saved_wolopts =3D __rtl8169_get_wol(t=
p);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0__rtl8169_set_wol(tp, WAKE_ANY);
>> + =C2=A0 =C2=A0 =C2=A0 tp->runtime_suspended =3D true;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irq(&tp->lock);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl8169_net_suspend(dev);
>> @@ -6125,6 +6128,7 @@ static int rtl8169_runtime_resume(struct devic=
e *device)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irq(&tp->lock);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0__rtl8169_set_wol(tp, tp->saved_wolopts);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tp->saved_wolopts =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 tp->runtime_suspended =3D false;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irq(&tp->lock);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl8169_init_phy(dev, tp);
>> @@ -6188,6 +6192,10 @@ static void rtl_shutdown(struct pci_dev *pdev=
)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct net_device *dev =3D pci_get_drvdat=
a(pdev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rtl8169_private *tp =3D netdev_pri=
v(dev);
>>
>> + =C2=A0 =C2=A0 =C2=A0 /* Get the device back to D0 state if it was =
runtime suspended. */
>> + =C2=A0 =C2=A0 =C2=A0 if (tp->runtime_suspended)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_set_power_sta=
te(pdev, PCI_D0);
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl8169_net_suspend(dev);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Restore original MAC address */
>> @@ -6195,6 +6203,10 @@ static void rtl_shutdown(struct pci_dev *pdev=
)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irq(&tp->lock);
>>
>> + =C2=A0 =C2=A0 =C2=A0 /* Restore WOL flags if they were messed arou=
nd with. */
>> + =C2=A0 =C2=A0 =C2=A0 if (tp->saved_wolopts)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __rtl8169_set_wol=
(tp, tp->saved_wolopts);
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl8169_hw_reset(tp);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irq(&tp->lock);
>> --
>> 1.7.7.3
>>
>
>
>
> --
> Sameer



--=20
Sameer
