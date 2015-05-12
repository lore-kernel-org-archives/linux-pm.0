From: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH RESEND v4 2/2] thermal: hisilicon: add new hisilicon thermal
 sensor driver
Date: Tue, 12 May 2015 19:20:41 +0800
Message-ID: <5551E209.7030902@hisilicon.com>
References: <1430707940-14468-1-git-send-email-kong.kongxinwei@hisilicon.com> <1430707940-14468-3-git-send-email-kong.kongxinwei@hisilicon.com> <20150512012926.GD4810@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512012926.GD4810-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, Javi.Merino-5wv7dgnIgG8@public.gmane.org, jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org, gongyu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zhenwei.wang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, z.liuxinliang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Fansaihua <fansaihua-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, jason.chenjian-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.orgzhenwei.wang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, wanghuan4-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2015/5/12 9:29, Eduardo Valentin wrote:
> Dear Kongxinwei,
>=20
>=20
> Apologize for late answer. I really missed this one. Let's make it fo=
r
> the next merge window!
>=20
> Please find a couple of comments as follows.
>=20
>=20
> On Mon, May 04, 2015 at 10:52:20AM +0800, Xinwei Kong wrote:
>> From: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>
>> This patch adds the support for hisilicon thermal sensor, within
>> hisilicon SoC. there will register sensors for thermal framework
>> and use device tree to bind cooling device.
>>
>> +
>> +static void hisi_thermal_enable_sensor(struct hisi_thermal_data *da=
ta)
>> +{
>> +	hisi_thermal_bind_irq(data);
>> +}
>> +
>> +static void hisi_thermal_disable_sensor(struct hisi_thermal_data *d=
ata)
>> +{
>> +
>> +	mutex_lock(&data->thermal_lock);
>> +
>> +	/* disable sensor module */
>> +	writel(0x0, data->regs + TEMP0_INT_EN);
>> +	writel(0x0, data->regs + TEMP0_RST_MSK);
>> +	writel(0x0, data->regs + TEMP0_EN);
>> +
>> +	mutex_unlock(&data->thermal_lock);
>> +
>=20
> nit: remove empty line.
>=20
>> +}
>> +
>> +static int hisi_thermal_get_temp(void *_sensor, long *temp)
>> +{
>> +	struct hisi_thermal_sensor *sensor =3D _sensor;
>> +	struct hisi_thermal_data *data =3D sensor->thermal;
>> +
>> +	int sensor_id =3D 0, i;
>> +	long max_temp =3D 0;
>> +
>> +	*temp =3D hisi_thermal_get_sensor_temp(data, sensor);
>> +
>> +	data->sensor_temp[sensor->id] =3D *temp;
>> +
>> +	for (i =3D 0; i < HISI_MAX_SENSORS; i++) {
>> +		if (data->sensor_temp[i] >=3D max_temp) {
>> +			max_temp =3D data->sensor_temp[i];
>> +			sensor_id =3D i;
>> +		}
>> +	}
>> +
>> +	data->irq_bind_sensor =3D sensor_id;
>=20
> I believe this irq_bind_sensor needs to be protected by a lock.
>=20
> You read it in t_irq context, write it here while getting temp, and r=
ead
> it in bind irq.

OK, add mutex lock to protected this variable.

>=20
> I still don't follow why you need it though, can you please explain?

The thermal sensor module has four sensors (local=E3=80=81acpu0=E3=80=81=
acpu1=E3=80=81gpu),
=46our sensor share or use the same register. let diff sensor ip enable
by setting diff bit for the same register. For the interrupt it has
only one interrupt signal; This interrupt signal can only be used by
one sensor;

=46or example, Four sensor can generate interrupt signal by selecting s=
ensor
which use  "writel((sensor->id << 12), data->regs + TEMP0_CFG)" , when
using sensor->id value to enable diff sensor, the enabled sensor maybe
generate the interrupt signal while other three sensor don't generate t=
he
interrupt signal.

=46our sensor ip distribute diff situation in the Soc. We will use kern=
el to
decide the interrupt signal binding one of four sensor. However, the bi=
nding
sensor will be close to interrupt status. the variable "irq_bind_sensor=
" will
record this binding sensor id.

>=20
> In any case, seams to be racy, given that it is shared by the four
> sensors, but you don't lock it to use it.
>=20
>> +
>> +	dev_dbg(&data->pdev->dev, "id=3D%d, irq=3D%d, temp=3D%ld, thres=3D=
%d\n",
>> +		sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
>> +	/*
>> +	 * Bind irq to sensor for two cases:
>> +	 *   Reenable alarm IRQ if temperature below threshold;
>> +	 *   if irq has been enabled, always set it;
>> +	 */
>> +	if (data->irq_enabled) {
>> +		hisi_thermal_bind_irq(data);
>> +		return 0;
>> +	}
>> +
>> +	if (max_temp < sensor->thres_temp) {
>> +		data->irq_enabled =3D true;
>> +		hisi_thermal_bind_irq(data);
>> +		enable_irq(data->irq);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct thermal_zone_of_device_ops hisi_of_thermal_ops =3D {
>> +	.get_temp =3D hisi_thermal_get_temp,
>> +};
>> +
>> +static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
>> +{
>> +	struct hisi_thermal_data *data =3D dev;
>> +
>> +	disable_irq_nosync(irq);
>> +	data->irq_enabled =3D false;
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev=
)
>> +{
>> +	struct hisi_thermal_data *data =3D dev;
>> +	struct hisi_thermal_sensor *sensor;
>> +	int i;
>> +
>> +	sensor =3D &data->sensors[data->irq_bind_sensor];
>> +
>> +	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
>> +		 sensor->thres_temp / 1000);
>=20
> Do you really want to be printing this every time you receive an IRQ?

This print information will display some sensor which generate the inte=
rrupt
signal. If deleting it,We don't know which sensor generate interrupt si=
gnal.

Generating interruption frequency is low. When the temperature of bindi=
ng
sensor is higher than "thres_temp" value, this will print it. But in th=
e thermal
framework it will get temperature by polling sensor, then cooling this =
device.
During polling time the sensor temperature is higher than "thres_temp" =
value,it
can generate interrupt signal. The interrupt dealing is helpful to the =
polling
machine.

>=20
>> +
>> +	for (i =3D 0; i < data->sensors_num; i++)
>> +		thermal_zone_device_update(data->sensors[i].tzd);
>=20
>=20
> Can you please educate me on how this chip works?

This chip have four sensors, every time you can only use one sensor by =
selecting
sensor register. At the same time one sensor is regular work, you requi=
re to
set the same register for the diff bit.

>=20
> You receive a thermal alarm from the chip, does it really  mean you h=
ave
> to update all thermal zones? Or do you have a way to check which sens=
or
> generated the alarm irq?
>=20

If one sensor generate interrupt signal, it will update all thermal zon=
es.

>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int hisi_thermal_register_sensor(struct platform_device *pde=
v,
>> +					struct hisi_thermal_data *data,
>> +					struct hisi_thermal_sensor *sensor,
>> +					int index)
>> +{
>> +	int ret, i;
>> +
>> +	sensor->id =3D index;
>> +	sensor->thermal =3D data;
>> +
>> +	sensor->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, sensor=
->id,
>> +				sensor, &hisi_of_thermal_ops);
>> +	if (IS_ERR(sensor->tzd)) {
>> +		ret =3D PTR_ERR(sensor->tzd);
>> +		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
>> +			sensor->id, ret);
>> +		return ret;
>> +	}
>> +
>> +	sensor->trip =3D of_thermal_get_trip_points(sensor->tzd);
>> +
>> +	for (i =3D 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
>> +		if (sensor->trip[i].type =3D=3D THERMAL_TRIP_PASSIVE) {
>=20
> what if you have more than one passive trip? You just care about the
> first?
>=20

Yes, this "passive" type have satisfied the demands for our Soc.

>> +			sensor->thres_temp =3D sensor->trip[i].temperature;
>=20
> Looks like you use sensor->trip only for filling thres_temp here. Doe=
s
> it make sense to use a local variable in this function, given you won=
't
> use sensor->trip anywhere else?
>=20
good idea. I understand it. I remove this "const struct thermal_trip *t=
rip;"
from " struct hisi_thermal_sensor". Then use it in this function.

>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id of_hisi_thermal_match[] =3D {
>> +	{ .compatible =3D "hisilicon,tsensor" },
>> +	{ /* end */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
>> +
>> +static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *=
sensor,
>> +				       bool on)
>> +{
>> +	struct thermal_zone_device *tzd =3D sensor->tzd;
>> +
>> +	tzd->ops->set_mode(tzd,
>> +		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
>> +}
>> +
>> +static int hisi_thermal_probe(struct platform_device *pdev)
>> +{
>> +	struct hisi_thermal_data *data;
>> +	struct resource *res;
>> +	int i;
>> +	int ret;
>> +
>> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&data->thermal_lock);
>> +	data->pdev =3D pdev;
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	data->regs =3D devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(data->regs)) {
>> +		dev_err(&pdev->dev, "failed to get io address\n");
>> +		return PTR_ERR(data->regs);
>> +	}
>> +
>> +	data->irq =3D platform_get_irq(pdev, 0);
>> +	if (data->irq < 0)
>> +		return data->irq;
>> +
>> +	ret =3D devm_request_threaded_irq(&pdev->dev, data->irq,
>> +			hisi_thermal_alarm_irq, hisi_thermal_alarm_irq_thread,
>> +			0, "hisi_thermal", data);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, data);
>> +
>> +	data->clk =3D devm_clk_get(&pdev->dev, "thermal_clk");
>> +	if (IS_ERR(data->clk)) {
>> +		ret =3D PTR_ERR(data->clk);
>> +		if (ret !=3D -EPROBE_DEFER)
>> +			dev_err(&pdev->dev,
>> +				"failed to get thermal clk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* enable clock for thermal */
>> +	ret =3D clk_prepare_enable(data->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i =3D 0; i < HISI_MAX_SENSORS; ++i) {
>> +		ret =3D hisi_thermal_register_sensor(pdev, data,
>> +					&data->sensors[i], i);
>> +		if (ret) {
>> +			dev_err(&pdev->dev,
>> +			"failed to register thermal sensor: %d\n", ret);
>> +			goto err_get_sensor_data;
>> +		}
>> +	}
>> +
>> +	hisi_thermal_enable_sensor(data);
>> +	data->irq_enabled =3D true;
>> +
>> +	for (i =3D 0; i < data->sensors_num; i++)
>> +		hisi_thermal_toggle_sensor(&data->sensors[i], true);
>> +
>> +	return 0;
>> +
>> +err_get_sensor_data:
>> +	clk_disable_unprepare(data->clk);
>=20
> nit: empty line here to follow your pattern.
>=20
>> +	return ret;
>> +}
>> +
>> +static int hisi_thermal_remove(struct platform_device *pdev)
>> +{
>> +	struct hisi_thermal_data *data =3D platform_get_drvdata(pdev);
>> +	int i;
>> +
>> +	for (i =3D 0; i < data->sensors_num; i++) {
>> +		struct hisi_thermal_sensor *sensor =3D &data->sensors[i];
>> +
>> +		hisi_thermal_toggle_sensor(sensor, false);
>> +		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
>> +	}
>> +
>> +	hisi_thermal_disable_sensor(data);
>> +	clk_disable_unprepare(data->clk);
>=20
> nit: empty line here to follow your pattern.
>=20
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int hisi_thermal_suspend(struct device *dev)
>> +{
>> +	struct hisi_thermal_data *data =3D dev_get_drvdata(dev);
>> +
>> +	hisi_thermal_disable_sensor(data);
>> +	data->irq_enabled =3D false;
>> +
>> +	clk_disable_unprepare(data->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_thermal_resume(struct device *dev)
>> +{
>> +	struct hisi_thermal_data *data =3D dev_get_drvdata(dev);
>> +
>> +	clk_prepare_enable(data->clk);
>> +
>> +	data->irq_enabled =3D true;
>> +	hisi_thermal_enable_sensor(data);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
>> +			 hisi_thermal_suspend, hisi_thermal_resume);
>> +
>> +static struct platform_driver hisi_thermal_driver =3D {
>> +	.driver =3D {
>> +		.name	=3D "hisi_thermal",
>> +		.owner  =3D THIS_MODULE,
>> +		.pm	=3D &hisi_thermal_pm_ops,
>> +		.of_match_table =3D of_hisi_thermal_match,
>=20
>=20
> nit: align on the '=3D' operator.
>=20
>> +	},
>> +	.probe		=3D hisi_thermal_probe,
>> +	.remove		=3D hisi_thermal_remove,
>> +};
>> +
>> +module_platform_driver(hisi_thermal_driver);
>> +
>> +MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>");
>> +MODULE_AUTHOR("Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
>> +MODULE_DESCRIPTION("Hisilicon thermal driver");
>> +MODULE_LICENSE("GPL v2");
>> --=20
>> 1.9.1
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
